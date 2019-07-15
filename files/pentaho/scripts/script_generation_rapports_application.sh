#!/bin/bash

MYSQL_PWD=root66
date_year=$(date --date="$(date +%Y-%m-15) -1 month" +'%Y')
date_month=$(date --date="$(date +%Y-%m-15) -1 month" +'%m')
date_month_folder=${date_year}${date_month}
root_folder=/srv/eyesofnetwork/eorweb/module/birt_reports/files/Applications
month_folder=${root_folder}/${date_month_folder}
application_list=${month_folder}/liste_application.txt
log_file=/var/log/eyesofreport/creation_rapports_application.log

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
			mkdir -p $month_application_folder
			cd $month_application_folder
			application=$(echo $line_appli | sed -e 's/ /_/g')
			contract_context=$(echo $contract_context_name | sed -e 's/ /_/g')
			report_name="${date_month_folder}-${contract_context}-${application}.pdf"
			rm -f $report_name
			echo $(date +"%Y-%m-%d %r") "Génération rapport $application ($contract_context_name) pour le ${date_year}-${date_month}" >> ${log_file}
			application=$line_appli
			wget -q -O $report_name "http://localhost:8080/birt/run?__report=EOR_Application_basic_FR.rptdesign&__format=PDF&Year=${date_year}&__isdisplay__Year=${date_year}&Month=${date_month}&__isdisplay__Month=${date_month}&Level=${application_level}&__isdisplay__Level=${application_level}&Application=${application_id}&__isdisplay__Application=${application}&Contract_contxt=${contract_context_id}&__isdisplay__Contract_contxt=${contract_context_name}" > /dev/null
		done
	fi
done < ${application_list}


cd $month_folder

rm -f ${application_list}

chown -R root:eyesofnetwork ${root_folder}
