module Commands exposing (fetchData, fetchMore)

import Decoders exposing (initDecoder, postsDecoder)
import Http
import Types exposing (Msg(..))


fetchData : Cmd Msg
fetchData =
    Http.get
        { url = "data.json"
        , expect = Http.expectJson GotMainPage initDecoder
        }


fetchMore : Cmd Msg
fetchMore =
    Http.get
        { url = "more_data.json"
        , expect = Http.expectJson GotMorePosts postsDecoder
        }
