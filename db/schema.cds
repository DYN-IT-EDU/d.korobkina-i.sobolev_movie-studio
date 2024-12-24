namespace sap.capire.moviestudioproject;

using {
    cuid,
    managed,
    sap.common.CodeList,
    Country,
    Currency,
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
    budget      : MonetaryValue;
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
    status      : SceneStatuses  @mandatory  @assert.range;
    expenses    : Composition of many Expenses
                      on expenses.scene = $self;
}

entity SceneActors : cuid, managed {
    movie         : Association to Movies;
    scene         : Association to Scenes;
    actor         : Association to People;
    characterName : String;
}

entity Contracts : cuid, managed {
    movie   : Association to Movies;
    person  : Association to People;
    role    : Association to Roles;
    salary  : MonetaryValue;
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
        Scenes.status = 'finished'
    group by
        Movies.ID,
        title,
        Movies.duration;


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

/*entity SceneStatuses : CodeList {
    key ID : Integer
}**/
type SceneStatuses  : String enum {

    in_progress;
    finished;
    rejected;


}

entity OrderStatuses : CodeList {
    key ID : Integer
}

entity Expenses : cuid, managed {
    scene       : Association to Scenes @mandatory;
    category    : Association to ExpenseCategories;
    expense     : MonetaryValue;
    description : String;
    expenseDate : Date;
}

entity ExpenseCategories : cuid, managed {
    name        : String @mandatory;
    description : String;
}

type SceneLocation {
    country : Country;
    address : String;
}

type MonetaryValue {
    amount   : Decimal(15, 2);
    currency : Currency;
}

type SceneLocations : many SceneLocation;
