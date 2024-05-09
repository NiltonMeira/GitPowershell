function nisa {
    Param (
        [string]$command,
        [string]$name
    )

    $currentDirectory = (Get-Location).Path
    $destinationDirectory = "$currentDirectory/nisa"
    
    $i = 0

    switch ($command) {

        init {
            New-item -Path "$destinationDirectory" -ItemType Directory
            New-item -Path "$destinationDirectory/add.txt"
            Write-Host "Directory created."
        }

        commit {

            $arquivo = Get-ChildItem -Path $currentDirectory
            [string[]]$addContent = get-content -Path "$currentDirectory/add.txt"
            Write-Host $addContent


            for ($i = 0; $i -lt $addContent.Count; $i++) {
                for ($j = 0; $j -lt $arquivo.Count; $j++) {
                    if ($addContent[$i] -eq $arquivo[$j].Name) {
                        if (-not(Test-Path -Path "$destinationDirectory/$name")) {
                            New-item -Path "$destinationDirectory/$name" -ItemType Directory
                        }
                        Copy-Item $arquivo[$j] -Destination "$destinationDirectory/$name" 
                    }
                }
            }
        }

        Default {
            Write-Output "Invalid command."
        }
    }
}
