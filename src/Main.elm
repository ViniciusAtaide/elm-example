module Main exposing (main)

import Browser exposing (Document)
import Commands exposing (fetchData, fetchMore)
import Element as E
import Element.Font as F
import Maybe
import Types exposing (Model, Msg(..), RemoteData(..), toMaybe)
import Views exposing (body, edges, footer, header, license)


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { mainPost = Loading, posts = Success [] }
    , fetchData
    )


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotMainPage result ->
            case result of
                Ok firstModel ->
                    let
                        posts =
                            Success firstModel.posts

                        mainPost =
                            Success firstModel.mainPost

                        newModel =
                            { mainPost = mainPost, posts = posts }
                    in
                    ( newModel, Cmd.none )

                Err _ ->
                    ( { model | mainPost = Failure }, Cmd.none )

        LoadMore ->
            ( { model | posts = Loading }, fetchMore )

        GotMorePosts result ->
            case result of
                Ok posts ->
                    let
                        ps =
                            Maybe.withDefault [] <| toMaybe model.posts
                    in
                    ( { model | posts = Success <| ps ++ posts }, Cmd.none )

                Err _ ->
                    ( { model | posts = Failure }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Chata De Galocha"
    , body =
        [ E.layout [ F.family [ F.typeface "Gabriela Regular" ] ] <|
            E.column [ E.spacing 50, E.centerX, E.width E.fill, E.paddingEach { edges | bottom = 20 } ]
                [ E.column [ E.centerX, E.width (E.fill |> E.maximum 1120) ]
                    [ header
                    , body model
                    ]
                , footer
                , license
                ]
        ]
    }


main : Program Flags Model Msg
main =
    Browser.document
        { init = init, update = update, view = view, subscriptions = subscriptions }



-- HTTP
