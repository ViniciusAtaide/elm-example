module Main exposing (main)

import Browser exposing (Document)
import Decoders exposing (stateDecoder)
import Element as E
import Element.Font as F
import Html exposing (Html)
import Http
import Types exposing (Model(..), Msg(..))
import Views exposing (body, edges, footer, header, license)


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "data.json"
        , expect = Http.expectJson GotState stateDecoder
        }
    )


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        GotState result ->
            case result of
                Ok posts ->
                    ( Success posts, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Chata De Galocha"
    , body =
        [ E.layout [ F.family [ F.typeface "Gabriela Regular" ] ] <|
            E.column [ E.spacing 50, E.centerX, E.paddingEach { edges | bottom = 20 } ]
                [ E.column [ E.width (E.fill |> E.maximum 1120) ]
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
