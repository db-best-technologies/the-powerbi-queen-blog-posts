# Download SSO.Gov ZIP file with first names by state
Invoke-WebRequest "https://www.ssa.gov/oact/babynames/state/namesbystate.zip" `
               -OutFile "C:\Temp\NamesByState.zip"

# Extract files from ZIP file onto local computer
Expand-Archive -LiteralPath "C:\Temp\NamesByState.zip" `
               -DestinationPath "C:\Temp\NamesByZip" 

# TODO: Once the TXT files are extracted, 
#       - Append all the TXT files into a single CSV file for PBI.
#       - Use nice column names for the columns. 
<<<<<<< HEAD
# 
# DeNisha Malone
=======
# Bill's change
>>>>>>> 5cb8f750062130f0b36fcaf679f49f10720114e2
