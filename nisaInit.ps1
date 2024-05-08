function nisa {
    Param (
        [string]$command,
        [string]$name
    )

    $currentDirectory = (Get-Location).Path
    $destinationDirectory = "$currentDirectory/$name"


    switch ($command) {

        init {
            New-item -Path "$destinationDirectory" -ItemType Directory
            New-item -Path "$destinationDirectory/add.txt"
            Write-Host "Directory created."
        }

        commit {

            $arquivo = Get-ChildItem -Path $currentDirectory
            $addContent = get-content -Path "$currentDirectory/add.txt"

            foreach ($file in $addContent)
            {
                if($file -contains $arquivo){
                    #Copy-Item $arquivo.FullName -Destination "$destinationDirectory" 
                    Write-Host "Contem"
                }
            }

            Write-Host $arquivo[3]
        }

        Default {
            Write-Output "Invalid command."
        }
    }
}
