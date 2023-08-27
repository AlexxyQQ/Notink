# Flutter Template

| Android | ✅  |
| ------- | --- |
| Windows | ✅  |
| Linux   | ✅  |
| MacOS   | ✅  |
| iOS     | ❌  |


## About the Template
This flutter template is based on **Clean Code Architecture** and **MVVM pattern**. The template supports all the platforms listed above with the exception of iOS. This repo will be updated in the future according to the needs.

## Folder Structure
    lib
        config
            constants
            router
            themes
        core
            bloc
            common
            failure
            network
            usecases
            utils
            app.dart
        features
            feature 1
                data
                    data_sources
                        local_data_source
                        remote_data_source
                    models
                    repository
                domain
                    entities
                    repository
                    usecase
                presentaion
                    state
                    pages
                    widgets
                    viewmodel
        injection
        main.dart

## Get Started

#### Step 1
Create a repo using the template and clone with branches

#### Step 2
Clone the newly created repo in VS-Code

#### Step 3
Replace All "template" in the repo with "your_app_name"

#### Step 4
```
flutter pub get
```

#### Step 5
```
flutter run
```
