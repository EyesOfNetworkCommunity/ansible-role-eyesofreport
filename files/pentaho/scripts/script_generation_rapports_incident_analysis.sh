#!/bin/bash

MYSQL_PWD=root66
previous_year=$(date --date="$(date +%Y-%m-15) -1 month" +'%Y')
previous_month=$(date --date="$(date +%Y-%m-15) -1 month" +'%m')
date_month_folder=${previous_year}${previous_month}
date_month=${previous_year}-${previous_month}-01
root_folder=/srv/eyesofnetwork/eorweb/module/birt_reports/files/Analyse_Incidents
month_folder=${root_folder}/${date_month_folder}
application_list=${month_folder}/liste_application.txt
log_file=/var/log/eyesofreport/creation_rapports_analyse_incidents.log

mkdir -p ${month_folder}

current_datetime=$(date +"%Y-%m-%d %r")

MYSQL_PWD=$MYSQL_PWD mysql -uroot -e "SELECT distinct name from bp" global_nagiosbp | tail -n +2 > ${application_list}

nb_applications=$(cat ${application_list} | wc -l)
for i in $(seq 1 ${nb_applications})
do
	line_appli="$(cat ${application_list} | head -${i} | tail -1)"
	application=$line_appli
	application_id=$(MYSQL_PWD=$MYSQL_PWD mysql -uroot -e "SELECT dap_id from d_application where dap_name='$application' and dap_source = 'global'" eor_dwh | tail -n +2)
	application_level=$(MYSQL_PWD=$MYSQL_PWD mysql -uroot -e "SELECT dap_priority from d_application where dap_name='$application'" eor_dwh | tail -n +2)
	application=$(echo $line_appli | sed -e 's/ /_/g')
	month_application_folder=$month_folder/$application

	application=$line_appli
	contract_context_ids=$(MYSQL_PWD=$MYSQL_PWD mysql -uroot -e "select dca_dcc_id from d_contract_context_application inner join d_application on dap_id=dca_appli_id where dap_name='$application'" eor_dwh | tail -n +2)
	if [ -z "$contract_context_ids" ]; then
		echo $(date +"%Y-%m-%d %r") "L'application $application n'est liée a aucun contexte de contrat" >> ${log_file}
	else 
		for contract_context_id in $contract_context_ids
		do
			contract_context_name=$(MYSQL_PWD=$MYSQL_PWD mysql -uroot -e "select dcc_name from d_contract_context_application inner join d_application on dap_id=dca_appli_id inner join d_contract_context on dcc_id = dca_dcc_id where dap_name='$application' and dcc_id=$contract_context_id limit 1" eor_dwh | tail -n +2)
			echo $(date +"%Y-%m-%d %r") "Le contexte de contrat $contract_context_name sera utilisé pour l'application $application" >> ${log_file}
			incident_dates=$(MYSQL_PWD=$MYSQL_PWD mysql -uroot -e "select distinct aud_date from (SELECT aud_date,aud_contract_context_id,  sum(aud_unavailability) from f_dtm_appli_unavailability_day where aud_appli=$application_id and date_format(aud_date,'%Y-%m-01')='$date_month' and aud_contract_context_id=$contract_context_id group by aud_date, aud_contract_context_id having sum(aud_unavailability) > 0 order by aud_date)a;" eor_dwh | tail -n +2)
			if [ ! -z "$incident_dates" ]; then
				mkdir -p $month_application_folder
				cd $month_application_folder
				for date in $incident_dates
				do
					current_day=$(date -d "$date" '+%d')
					current_month=$(date -d "$date" '+%m')
					current_year=$(date -d "$date" '+%Y')
					application=$(echo $line_appli | sed -e 's/ /_/g')
					contract_context=$(echo $contract_context_name | sed -e 's/ /_/g')
					report_name=${date_month_folder}${current_day}-${contract_context}-${application}-analyse_incident.pdf
			      		rm -f $report_name
					echo $(date +"%Y-%m-%d %r") "Génération rapport $application ($contract_context_name) pour le ${current_year}-${current_month}-${current_day}" >> ${log_file}
					application=$line_appli
					wget -q -O $report_name "http://localhost:8080/birt/run?__report=EOR_Application_incident_analysis_FR.rptdesign&__format=PDF&Year=${current_year}&__isdisplay__Year=${current_year}&Month=${current_month}&__isdisplay__Month=${current_month}&Day=${current_day}&__isdisplay__Day=${current_day}&Niveau=${application_level}&__isdisplay__Niveau=${application_level}&Application=${application_id}&__isdisplay__Application=${application}&Contract_contxt=${contract_context_id}&__isdisplay__Contract_contxt=${contract_context_name}" >> /dev/null
				done
			else
				echo "Pas d'incidents sur la période pour $application" >> ${log_file}
			fi
		done
	fi
done < ${application_list}

cd $month_folder

rm -f ${application_list}

chown -R root:eyesofnetwork ${root_folder}

