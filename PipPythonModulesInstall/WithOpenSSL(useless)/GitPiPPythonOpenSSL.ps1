<<<<<<< HEAD
﻿# Funkcja do instalacji Chocolatey
function Install-Chocolatey {
    Write-Host "Sprawdzam, czy Chocolatey jest zainstalowany..."
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey nie jest zainstalowany. Instalowanie..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    } else {
        Write-Host "Chocolatey jest już zainstalowany."
    }
}

# Funkcja do instalacji Git
function Install-Git {
    Write-Host "Pobieranie i instalacja Git..."
    if (!(Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Git nie jest zainstalowany. Instalowanie..."
        winget install --id Git.Git -e --source winget
    } else {
        Write-Host "Git jest już zainstalowany."
    }
}

# Funkcja do sprawdzenia, czy Python jest zainstalowany
function Check-Python {
    Write-Host "Sprawdzam, czy Python jest zainstalowany..."
    if (Get-Command python -ErrorAction SilentlyContinue) {
        Write-Host "Python jest już zainstalowany."
        return $true
    } else {
        Write-Host "Python nie jest zainstalowany."
        return $false
    }
}

# Funkcja do dodania Pythona do zmiennej środowiskowej PATH
function Add-PythonToPath {
    Write-Host "Dodawanie Pythona do zmiennej środowiskowej PATH..."
    $pythonPath = "C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python310\Scripts"
    if (-not ($env:Path -contains $pythonPath)) {
        $env:Path += ";$pythonPath"
        Write-Host "Python został dodany do zmiennej PATH."
    } else {
        Write-Host "Ścieżka do Pythona jest już w zmiennej PATH."
    }
}

# Funkcja do instalacji Pythona (i pip)
function Install-Python {
    Write-Host "Pobieranie i instalacja Python (i pip)..."
    $pythonUrl = "https://www.python.org/ftp/python/3.10.8/python-3.10.8-amd64.exe"
    $installer = "python_installer.exe"
    $destination = "$env:USERPROFILE\Downloads\$installer"
    Invoke-WebRequest -Uri $pythonUrl -OutFile $destination
    Start-Process -FilePath $destination -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    # Upewnienie się, że pip jest dostępny
    python -m ensurepip --upgrade
    python --version
    pip --version
}

# Funkcja do instalacji pip
function Install-Pip {
    Write-Host "Sprawdzam, czy pip jest zainstalowany..."
    if (!(Get-Command pip -ErrorAction SilentlyContinue)) {
        Write-Host "pip nie jest zainstalowany. Instalowanie..."
        python -m ensurepip --upgrade
    } else {
        Write-Host "pip jest już zainstalowany."
    }
    # Aktualizacja pip, jeśli dostępna nowa wersja
    Write-Host "Aktualizowanie pip do najnowszej wersji..."
    python -m pip install --upgrade pip
}

# Funkcja do instalacji pakietów pip
function Install-PipPackages {
    Write-Host "Sprawdzam, czy pakiety pip są zainstalowane..."
    # Sprawdzanie, czy pakiety są zainstalowane
    $packages = @("requests", "mailtm", "certifi")
    foreach ($pkg in $packages) {
        $pkgInstalled = python -m pip show $pkg
        if ($pkgInstalled) {
            Write-Host "$pkg jest już zainstalowany."
        } else {
            Write-Host "$pkg nie jest zainstalowany. Instalowanie..."
            pip install $pkg
        }
    }
}


# Funkcja do instalacji Visual Studio Build Tools (w tym nmake)
function Install-BuildTools {
    Write-Host "Sprawdzam, czy Visual Studio Build Tools (nmake) są zainstalowane..."
    if (!(Get-Command nmake -ErrorAction SilentlyContinue)) {
        Write-Host "Visual Studio Build Tools nie są zainstalowane. Instalowanie..."
        # Próbujemy pobrać Visual Studio Build Tools ręcznie przez winget
        $installResult = winget install --id Microsoft.VisualStudio.2022.BuildTools -e --source winget --silent --accept-package-agreements --accept-source-agreements
        if ($installResult -like "*No package found*") {
            Write-Host "Błąd: Nie znaleziono pakietu Visual Studio Build Tools w winget."
        } else {
            Write-Host "Visual Studio Build Tools zostały pomyślnie zainstalowane."
        }
        # Dodajemy odpowiednie ścieżki do PATH
        $env:Path += ";C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\<wersja>\bin\Hostx64\x64"
        $env:Path += ";C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools"
        Write-Host "Ścieżki do Visual Studio Build Tools zostały dodane do zmiennej PATH."
    } else {
        Write-Host "Visual Studio Build Tools (nmake) są już zainstalowane."
    }
}

# Funkcja do instalacji OpenSSL przez Chocolatey
function Install-OpenSSL {
    Write-Host "Sprawdzam, czy OpenSSL jest zainstalowany..."
    if (!(Get-Command openssl -ErrorAction SilentlyContinue)) {
        Write-Host "OpenSSL nie jest zainstalowany. Instalowanie przez Chocolatey..."
        choco install openssl.light -y
    } else {
        Write-Host "OpenSSL jest już zainstalowany."
    }
}

# Funkcja główna do uruchomienia wszystkich kroków
function Main {
    Install-Chocolatey
    Install-Git

    # Sprawdzenie, czy Python jest zainstalowany
    $pythonInstalled = Check-Python
    if (-not $pythonInstalled) {
        Install-Python
    } else {
        Add-PythonToPath
    }

    Install-Pip
    Install-PipPackages
    Install-BuildTools
    Install-OpenSSL

    Write-Host "OpenSSL oraz wszystkie zależności zostały pomyślnie zainstalowane."
}

# Uruchomienie skryptu
=======
﻿# Funkcja do instalacji Chocolatey
function Install-Chocolatey {
    Write-Host "Sprawdzam, czy Chocolatey jest zainstalowany..."
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey nie jest zainstalowany. Instalowanie..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    } else {
        Write-Host "Chocolatey jest już zainstalowany."
    }
}

# Funkcja do instalacji Git
function Install-Git {
    Write-Host "Pobieranie i instalacja Git..."
    if (!(Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Git nie jest zainstalowany. Instalowanie..."
        winget install --id Git.Git -e --source winget
    } else {
        Write-Host "Git jest już zainstalowany."
    }
}

# Funkcja do sprawdzenia, czy Python jest zainstalowany
function Check-Python {
    Write-Host "Sprawdzam, czy Python jest zainstalowany..."
    if (Get-Command python -ErrorAction SilentlyContinue) {
        Write-Host "Python jest już zainstalowany."
        return $true
    } else {
        Write-Host "Python nie jest zainstalowany."
        return $false
    }
}

# Funkcja do dodania Pythona do zmiennej środowiskowej PATH
function Add-PythonToPath {
    Write-Host "Dodawanie Pythona do zmiennej środowiskowej PATH..."
    $pythonPath = "C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python310\Scripts"
    if (-not ($env:Path -contains $pythonPath)) {
        $env:Path += ";$pythonPath"
        Write-Host "Python został dodany do zmiennej PATH."
    } else {
        Write-Host "Ścieżka do Pythona jest już w zmiennej PATH."
    }
}

# Funkcja do instalacji Pythona (i pip)
function Install-Python {
    Write-Host "Pobieranie i instalacja Python (i pip)..."
    $pythonUrl = "https://www.python.org/ftp/python/3.10.8/python-3.10.8-amd64.exe"
    $installer = "python_installer.exe"
    $destination = "$env:USERPROFILE\Downloads\$installer"
    Invoke-WebRequest -Uri $pythonUrl -OutFile $destination
    Start-Process -FilePath $destination -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
    # Upewnienie się, że pip jest dostępny
    python -m ensurepip --upgrade
    python --version
    pip --version
}

# Funkcja do instalacji pip
function Install-Pip {
    Write-Host "Sprawdzam, czy pip jest zainstalowany..."
    if (!(Get-Command pip -ErrorAction SilentlyContinue)) {
        Write-Host "pip nie jest zainstalowany. Instalowanie..."
        python -m ensurepip --upgrade
    } else {
        Write-Host "pip jest już zainstalowany."
    }
    # Aktualizacja pip, jeśli dostępna nowa wersja
    Write-Host "Aktualizowanie pip do najnowszej wersji..."
    python -m pip install --upgrade pip
}

# Funkcja do instalacji pakietów pip
function Install-PipPackages {
    Write-Host "Sprawdzam, czy pakiety pip są zainstalowane..."
    # Sprawdzanie, czy pakiety są zainstalowane
    $packages = @("requests", "mailtm", "certifi")
    foreach ($pkg in $packages) {
        $pkgInstalled = python -m pip show $pkg
        if ($pkgInstalled) {
            Write-Host "$pkg jest już zainstalowany."
        } else {
            Write-Host "$pkg nie jest zainstalowany. Instalowanie..."
            pip install $pkg
        }
    }
}


# Funkcja do instalacji Visual Studio Build Tools (w tym nmake)
function Install-BuildTools {
    Write-Host "Sprawdzam, czy Visual Studio Build Tools (nmake) są zainstalowane..."
    if (!(Get-Command nmake -ErrorAction SilentlyContinue)) {
        Write-Host "Visual Studio Build Tools nie są zainstalowane. Instalowanie..."
        # Próbujemy pobrać Visual Studio Build Tools ręcznie przez winget
        $installResult = winget install --id Microsoft.VisualStudio.2022.BuildTools -e --source winget --silent --accept-package-agreements --accept-source-agreements
        if ($installResult -like "*No package found*") {
            Write-Host "Błąd: Nie znaleziono pakietu Visual Studio Build Tools w winget."
        } else {
            Write-Host "Visual Studio Build Tools zostały pomyślnie zainstalowane."
        }
        # Dodajemy odpowiednie ścieżki do PATH
        $env:Path += ";C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\<wersja>\bin\Hostx64\x64"
        $env:Path += ";C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools"
        Write-Host "Ścieżki do Visual Studio Build Tools zostały dodane do zmiennej PATH."
    } else {
        Write-Host "Visual Studio Build Tools (nmake) są już zainstalowane."
    }
}

# Funkcja do instalacji OpenSSL przez Chocolatey
function Install-OpenSSL {
    Write-Host "Sprawdzam, czy OpenSSL jest zainstalowany..."
    if (!(Get-Command openssl -ErrorAction SilentlyContinue)) {
        Write-Host "OpenSSL nie jest zainstalowany. Instalowanie przez Chocolatey..."
        choco install openssl.light -y
    } else {
        Write-Host "OpenSSL jest już zainstalowany."
    }
}

# Funkcja główna do uruchomienia wszystkich kroków
function Main {
    Install-Chocolatey
    Install-Git

    # Sprawdzenie, czy Python jest zainstalowany
    $pythonInstalled = Check-Python
    if (-not $pythonInstalled) {
        Install-Python
    } else {
        Add-PythonToPath
    }

    Install-Pip
    Install-PipPackages
    Install-BuildTools
    Install-OpenSSL

    Write-Host "OpenSSL oraz wszystkie zależności zostały pomyślnie zainstalowane."
}

# Uruchomienie skryptu
>>>>>>> 527b44de7045c2fc359e552a551e5dfa9259f79f
Main