import logging

import pyodbc 

import azure.functions as func

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    server = 'tcp:post-api-winopsdba-com-sql.database.windows.net,1433' 
    database = 'post-api' 
    username = 'f3rVUEbWi9FjBG7W5tXg85Zt' 
    password = '' 
    cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
    cursor = cnxn.cursor()

    #Sample insert query
    cursor.execute("""
    INSERT INTO timestamp (timestamp)  
    VALUES (GETDATE());
    """) 
    cnxn.commit()

    return func.HttpResponse(
            "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
            status_code=200
    )
