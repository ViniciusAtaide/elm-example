module Types exposing (..)

import Http


type Msg
    = GotState (Result Http.Error State)
    | NoOp


type alias Post =
    { id : Int
    , title : String
    , date_published : String
    , tags : List String
    , image : String
    , image_desc : String
    }


type alias State =
    { posts : List Post }


type Model
    = Failure
    | Loading
    | Success State
