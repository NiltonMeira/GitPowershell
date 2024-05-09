function nisa {
    Param (
        [string]$command,
        [string]$name
    )

    $currentDirectory = (Get-Location).Path
    $destinationDirectory = "$currentDirectory/nisa"
    $arquivo = Get-ChildItem -Path $currentDirectory
    
    $i = 0

    switch ($command) {

        init {
            New-item -Path "$destinationDirectory" -ItemType Directory
            New-item -Path "$destinationDirectory/add.txt"
            Write-Host "Directory created."
        }

        add {   

            if ($name -eq ".") {
                foreach ($file in $arquivo) {
                    if ($file -notmatch "nisa") {
                        Add-Content -Path "$destinationDirectory\add.txt" -Value $file
                    }
                }
            }

            else {
                foreach ($file in $arquivo) {
                    if ($name -eq $file) {
                        Add-Content -Path "$destinationDirectory\add.txt" -Value $file
                        Write-Host "the file $file was added"
                        break
                    }
                }
                Write-Host "This file doesn't exists"
            }
        }

        commit {

            [string[]]$addContent = get-content -Path "$destinationDirectory/add.txt"
            Write-Host $addContent
    
    
            for ($i = 0; $i -lt $addContent.Count; $i++) {
                for ($j = 0; $j -lt $arquivo.Count; $j++) {
                    if ($addContent[$i] -eq $arquivo[$j].Name) {
                        if (-not(Test-Path -Path "$destinationDirectory/$name")) {
                            New-item -Path "$destinationDirectory/$name" -ItemType Directory
                        }
                        Copy-Item $arquivo[$j] -Destination "$destinationDirectory/$name" -Recurse
                    }
                }
            }
            Set-Content -Path "$destinationDirectory/add.txt" -Value ""   
        }
    
        Default {
            Write-Output "Invalid command."
        }
    }   
}
