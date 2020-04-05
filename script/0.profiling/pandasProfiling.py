import pandas_profiling as pdf
from script.read.readData import *

outputPath = "output/pandas profiling/"


fiscProfile = fiscalizacion.profile_report()
fiscProfile.to_file(output_file = outputPath + "fiscProfile.html")

climaProfile = clima.profile_report()
climaProfile.to_file(output_file = outputPath + "climaProfile.html")

rusProfile = rus.profile_report()
rusProfile.to_file(output_file = outputPath + "rusProfile.html")

empresasProfile = empresas.profile_report()
empresasProfile.to_file(output_file = outputPath + "empresasProfile.html")

empresasContratistasProfile = empresasContratistas.profile_report()
empresasContratistasProfile.to_file(output_file = outputPath + "empresaContratistaProfile.html")
