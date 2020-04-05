import pandas as pd
# # # # # Read data 
# # # # # fiscalizacion : Datos de fiscalizacion de los controles
# # # # # clima : datos de clima provenientes de la estacion de Palermo
# # # # # empresasContratista : Tabla LU
# # # # # rus : Relevamiento de usos de suelo 201

fiscalizacion = pd.read_csv("./data/fiscalizacion.csv",sep=",")
clima = pd.read_csv("./data/clima.csv",sep=",")
empresasContratistas = pd.read_csv("./data/empresaContratista.csv",sep=";")
rus = pd.read_csv("./data/rus2017.csv",sep=",")
empresas = pd.read_excel("./data/empresas.xlsx",sep=",")

