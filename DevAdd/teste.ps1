function add {
    param (
        [string]$command
    )

    $currentDirectory = (Get-Location).Path
    $arquivos = Get-ChildItem -Path $currentDirectory
    
    if ($command -eq ".") {
        foreach ($file in $arquivos)
        {
            Add-Content -Path "$currentDirectory\add.txt" -Value $file
        }
    }

    else 
    {
        foreach ($file in $arquivos)
        {
            if ($command -eq $file) 
            {
                Add-Content -Path "$currentDirectory\add.txt" -Value $file
                Write-Host "the file $file was added"
                break
            }
        }
        Write-Host "This file doesn't exists"
    }
}

