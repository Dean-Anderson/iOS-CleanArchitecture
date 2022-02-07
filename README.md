# Clean Architecture

![clean](https://user-images.githubusercontent.com/61221666/115329711-a4316400-a1cd-11eb-9e1f-528488955017.png)

# Dependency Flow
UI -> ViewModel or Reactor -> UseCase -> Repository -> Entity

# SOLID
- Single Responbility : Modules has a single Responbility
- Open/Closed : Dependency was created by protocol
- Liskov Substitution : ImagePack > ImageCellCreatable
- Interface Segregation : ImageCellDrawable, ImageCellInteractable
- Dependency Inversion : Lower layer's Don't knows higher layer's information

# TO DO
- IOC Container - Inversion Of Control (Swinject)
