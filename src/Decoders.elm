module Decoders exposing (initDecoder, postsDecoder)

import Json.Decode as Decode exposing (Decoder, field)
import Types exposing (FetchModel, Post, RemoteData(..))


postDecoder : Decoder Post
postDecoder =
    Decode.map6 Post
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "date_published" Decode.string)
        (Decode.field "tags" (Decode.list Decode.string))
        (Decode.field "image" Decode.string)
        (Decode.field "image_desc" Decode.string)

postsDecoder : Decoder (List Post)
postsDecoder =
    Decode.field "posts"
        (Decode.list postDecoder)

initDecoder : Decoder FetchModel
initDecoder =
    Decode.map2 FetchModel
        (Decode.field "mainPost" postDecoder)
        postsDecoder
