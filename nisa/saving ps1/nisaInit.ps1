function nisa {
    Param (
        [string]$command,
        [string]$name
    )

    $currentDirectory = (Get-Location).Path
    $destinationDirectory = "$currentDirectory/nisa"
    $arquivo = Get-ChildItem -Path $currentDirectory

    switch ($command) {

        init { #creating the nisa directory

            New-item -Path "$destinationDirectory" -ItemType Directory
            New-item -Path "$destinationDirectory/add.txt"
            Write-Host "Directory created at destination: $currentDirectory"
        }

        add {  #adding files names in "add.txt" 

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
                        Write-Host "The file $file was added"
                        break
                    }
                }
                Write-Host "This file doesn't exists"
            }
        }

        commit { #adding the files at nisa directory

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