namespace sap.capire.moviestudioproject;

using {
    cuid,
    managed,
    sap.common.CodeList,
    Country
} from '@sap/cds/common';

entity People : cuid, managed {
    firstName      : String @mandatory;
    lastName       : String @mandatory;
    name           : String = firstName || ' ' || lastName;
    dateOfBirth    : Date;
    countryOfBirth : Country

}


entity Movies : cuid, managed {
    title       : String(255);
    releaseDate : Date;
    duration    : Integer;
    budget      : Decimal(15, 2);
    synopsis    : String;
    scenes      : Composition of many Scenes
                      on scenes.movie = $self;
    genres      : Association to many MovieGenres
                      on genres.movie = $self;

}

entity Scenes : cuid, managed {
    movie       : Association to Movies;
    description : String;
    duration    : Integer;
    location    : SceneLocations;
    status      : Association to SceneStatuses  @mandatory  @assert.range;
}

entity SceneActors : cuid, managed {
    movie         : Association to Movies;
    scene         : Association to Scenes;
    actor         : Association to People;
    characterName : String;
}

entity MoviePeople : cuid, managed {
    movie   : Association to Movies;
    person  : Association to People;
    role    : Association to Roles;
    details : String;
}

entity MovieProgress as
    select from Movies
    left join Scenes
        on Movies.ID = Scenes.movie.ID
    {
        title,
        Movies.ID,
        Movies.duration as Projected_Movie_Duration,
        sum(
            Scenes.duration
        )               as Actual_duration
    }
    where
        Scenes.status.ID = 2
    group by
        Movies.ID;


entity Equipment : cuid, managed {
    name        : String;
    type        : String;
    modelNumber : String(100);
    quantity    : Integer;
}

entity EquipmentOrders : cuid, managed {
    scene  : Association to Scenes;
    status : Association to OrderStatuses;
    date   : Date;
    items  : Composition of many EquipmentOrderItem
                 on items.equipmentOrder = $self

}

entity EquipmentOrderItem : cuid, managed {
    equipmentOrder : Association to EquipmentOrders;
    equipment      : Association to Equipment;
    quantity       : Integer
}


entity Roles : cuid, managed {
    name        : String(255);
    description : String;
}

entity Genres : cuid, managed {
    genre : String
};

entity MovieGenres : cuid, managed {
    movie     : Association to Movies;
    genreName : Association to Genres;

}

entity SceneStatuses : CodeList {
    key ID : Integer
}

entity OrderStatuses : CodeList {
    key ID : Integer
}


type SceneLocation {
    country : Country;
    address : String;
}

type SceneLocations : many SceneLocation;
