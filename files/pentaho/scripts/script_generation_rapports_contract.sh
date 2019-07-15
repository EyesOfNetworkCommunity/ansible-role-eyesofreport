#!/bin/bash

MYSQL_PWD=root66
date_year=$(date --date="$(date +%Y-%m-15) -1 month" +'%Y')
date_month=$(date --date="$(date +%Y-%m-15) -1 month" +'%m')
date_month_folder=${date_year}${date_month}
root_folder=/srv/eyesofnetwork/eorweb/module/birt_reports/files/Contrats
month_folder=${root_folder}/${date_month_folder}
log_file=/var/log/eyesofreport/creation_rapports_contrats.log

mkdir -p ${month_folder}
cd ${month_folder}

current_datetime=$(date +"%Y-%m-%d %r")

contract_context_ids=$(MYSQL_PWD=$MYSQL_PWD mysql -uroot -e "select distinct(dca_dcc_id) from d_contract_context_application" eor_dwh | tail -n +2)
if [ -z "$contract_context_ids" ]; then
	echo $(date +"%Y-%m-%d %r") "Aucun contexte de contrat" >> ${log_file}
else 
	for contract_context_id in $contract_context_ids
	do
		contract_context_name=$(MYSQL_PWD=$MYSQL_PWD mysql -uroot -e "select dcc_name from d_contract_context_application inner join d_application on dap_id=dca_appli_id inner join d_contract_context on dcc_id = dca_dcc_id where dcc_id=$contract_context_id limit 1" eor_dwh | tail -n +2)
		echo $(date +"%Y-%m-%d %r") "Le contexte de contrat $contract_context_name sera utilisé" >> ${log_file}
		contract_context=$(echo $contract_context_name | sed -e 's/ /_/g')
		contract_context_name_=$(echo $contract_context_name | sed -e 's/ /+/g')
		report_name="${date_month_folder}-${contract_context}.pptx"
		rm -f $report_name
		echo $(date +"%Y-%m-%d %r") "Génération rapport $contract_context_name pour le ${date_year}-${date_month}" >> ${log_file}
		wget -q -O $report_name "http://localhost:8080/birt/run?__report=EOR_Contract_Application_FR.rptdesign&__format=pptx&Year=${date_year}&__isdisplay__Year=${date_year}&Month=${date_month}&__isdisplay__Month=${date_month}&contract_context=${contract_context_name_}&__isdisplay__contract_context=${contract_context_name}" > /dev/null
	done
fi

chown -R root:eyesofnetwork ${root_folder}
