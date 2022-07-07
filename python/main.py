import os
import requests
import boto3
from datetime import date,timedelta
from botocore.exceptions import NoCredentialsError

#se ha borrado el aws_access_key_id y el aws_secret_access_key por motivos de seguridad.

def upload_to_aws(bucket, s3_file,file_url):
    s3 = boto3.client('s3', aws_access_key_id= ,
                      aws_secret_access_key= )

    r = requests.get(file_url, stream = True)
    
    try:
        with open("/tmp/temporal.csv","wb") as data:
            data.write(r.content)
            data.seek(0, os.SEEK_END)
            if data.tell()>10**5:        
                with open('/tmp/temporal.csv', 'rb') as data:
                    s3.upload_fileobj(data, bucket, s3_file)   
            else:
                print("Incorrect file")
                return False
        print("Upload Successful")
        return True
    except FileNotFoundError:
        print("The file was not found")
        return False
    except NoCredentialsError:
        print("Credentials not available")
        return False
def load_all(event, context):
    upload_to_aws('covidmoderndatastack', 'cases.csv',"https://cnecovid.isciii.es/covid19/resources/casos_hosp_uci_def_sexo_edad_provres.csv")
    upload_to_aws('covidmoderndatastack', 'hospitals.csv',"https://www.sanidad.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/documentos/Datos_Capacidad_Asistencial_Historico_"+(date.today()).strftime("%d%m%Y")+".csv")
    if os.path.exists("tmp/temporal.csv"):
        os.remove("tmp/temporal.csv")
    else:
        print("The file does not exist")