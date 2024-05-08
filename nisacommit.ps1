function nisa {
    Param (
        [string]$command,
        [string]$name
    )

    $currentDirectory = (Get-Location).Path
    $destinationDirectory = "$currentDirectory/$name"

    switch -Regex ($command) {

        commit {
            Copy-Item -path "$currentDirectory\*" -Destination $destinationDirectory -Recurse
            Write-Host "Commited!"
        }

        Default {
            Write-Output "Invalid command."
        }
    }
}