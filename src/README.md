## Информация

Проект запускается следующими командами

    cd src/webapi
    dotnet watch run

*Примечание: При обновлении ангуляр скрипта net core сервер автоматически пересобирает ангуляр сборку.*

Сайт находится здесь - http://localhost:5001 

Разработка ведется в **vs code**, в которой присутствует итеграция с git.

Удобно использовать следующие плагины при разработке:

- Markdown All in One
- Markdown Preview Enhanced

Наши хоткеи, которые открываются через `ctr + shift + p` -> "pkjs":

    // Place your key bindings in this file to override the defaultsauto[]
    [
        {
            "key": "insert",
            "command": "git.commitAll"
        },
        {
            "key": "ctrl+numpad_multiply",
            "command": "git.push"
        }
    ]