module Decoders exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Types exposing (Post, State)


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


stateDecoder : Decoder State
stateDecoder =
    Decode.map State postsDecoder
