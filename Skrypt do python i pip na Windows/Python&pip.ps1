# Skrypt PowerShell do automatycznej instalacji Pythona i pip
$python_url = "https://www.python.org/ftp/python/3.10.8/python-3.10.8-amd64.exe" 
$installer = "python_installer.exe"
$destination = "$env:USERPROFILE\Downloads\$installer"
Invoke-WebRequest -Uri $python_url -OutFile $destination
Start-Process -FilePath $destination -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Invoke-WebRequest https://bootstrap.pypa.io/get-pip.py -OutFile get-pip.py
python --version
pip --version