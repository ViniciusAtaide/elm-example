module Types exposing (FetchModel, Model, Msg(..), Post, RemoteData(..), toMaybe)

import Http


type RemoteData a
    = Loading
    | Failure
    | Success a


toMaybe : RemoteData a -> Maybe a
toMaybe a =
    case a of
        Success d ->
            Just d

        _ ->
            Nothing


type alias FetchModel =
    { mainPost : Post
    , posts : List Post
    }


type Msg
    = GotMainPage (Result Http.Error FetchModel)
    | LoadMore
    | GotMorePosts (Result Http.Error (List Post))
    | NoOp


type alias Post =
    { id : Int
    , title : String
    , date_published : String
    , tags : List String
    , image : String
    , image_desc : String
    }


type alias Model =
    { mainPost : RemoteData Post
    , posts : RemoteData (List Post)
    }
