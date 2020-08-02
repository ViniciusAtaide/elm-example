module Views exposing (body, borderButton, edges, footer, header, license)

import Element exposing (..)
import Element.Background as EB
import Element.Border as B
import Element.Events as EE
import Element.Font as EF
import Element.Input as EI
import Html as H
import Html.Attributes as HA
import Types exposing (Model(..), Msg(..), Post, State)



---------------
--  HELPERS ---
---------------


edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }


borderButton : List (Attribute msg)
borderButton =
    [ B.color <| rgb 0 0 0
    , B.width 1
    , B.solid
    , B.rounded 5
    , paddingXY 10 5
    ]


active =
    rgb255 159 115 167


iconRede : String -> String -> String -> String -> Element msg
iconRede href bp w img =
    el [ alignRight ] <|
        html <|
            H.a
                [ HA.href href
                , HA.style "margin-left" "10px"
                , HA.style "background-image" <| "url('" ++ img ++ "')"
                , HA.style "background-repeat" "no-repeat"
                , HA.style "background-size" "148px 22px"
                , HA.style "height" "22px"
                , HA.style "width" w
                , HA.style "text-indent" "-9999px"
                , HA.style "background-position" bp
                ]
                [ H.text "" ]



----------------
----------------
----------------


post : Element msg
post =
    row [ spacing 30, width fill ]
        [ image
            [ width (fill |> maximum 240)
            , height (fill |> maximum 240)
            ]
            { src = "images/photo.jpeg", description = "Rotina" }
        , column [ alignTop, width fill, spacing 10 ]
            [ row
                [ paddingXY 0 10
                , width fill
                , EF.family [ EF.typeface "Verdana", EF.sansSerif ]
                ]
                [ paragraph
                    [ EF.italic
                    , EF.size 18
                    , EF.color active
                    , alignLeft
                    ]
                    [ text "Lifestyle" ]
                , el [ EF.size 12, EF.extraLight ] (text "22.07.2020")
                ]
            , el [ width fill, EF.size 24 ] <| text "Vlog: minha rotina à noite"
            , paragraph
                [ EF.extraLight, moveDown 20, EF.size 16 ]
                [ text "Como tem sido as suas noites por aí? Por aqui eu tenho tentado me desligar do trabalho, fazer um comidinha[...]"
                ]
            ]
        ]


mainPost : Post -> Element msg
mainPost p =
    el
        [ width fill
        , height fill
        , alignBottom
        , inFront <|
            paragraph [ EF.center, EF.italic, alignBottom, paddingEach { edges | bottom = 30 } ] <|
                [ el [ paddingXY 10 10, EB.color (rgba 255 255 255 0.5) ] <| text p.title ]
        ]
    <|
        image [ width fill, height fill ] { src = "images/" ++ p.image, description = p.image_desc }


miniPost : Post -> Element msg
miniPost p =
    column
        [ spacing 15, width fill, alignTop ]
        [ image
            [ width fill ]
            { src = "images/" ++ p.image, description = p.image_desc }
        , row
            [ width fill ]
            [ row [ EF.color active, EF.italic, EF.size 14 ] <| List.map (\t -> text t) p.tags
            , el [ EF.size 12, alignRight ] <| text p.date_published
            ]
        , paragraph [ width fill, EF.size 22 ] [ text p.title ]
        ]


menu : Element msg
menu =
    row [ width fill, padding 10 ]
        [ row
            [ width fill, spacing 10 ]
            [ link [ mouseOver [ EF.color active ] ]
                { url = "#"
                , label = text <| String.toUpper "Moda"
                }
            , link [ mouseOver [ EF.color active ] ]
                { url = "#"
                , label = text <| String.toUpper "Beleza"
                }
            , link [ mouseOver [ EF.color active ] ]
                { url = "#"
                , label = text <| String.toUpper "Viagem"
                }
            , link [ mouseOver [ EF.color active ] ]
                { url = "#"
                , label = text <| String.toUpper "Comida"
                }
            , link [ mouseOver [ EF.color active ] ]
                { url = "#"
                , label = text <| String.toUpper "Lifestyle"
                }
            ]
        , row
            [ width fill ]
            [ iconRede "https://www.instagram.com/chatadegalocha/" "0" "22px" "icons/sidebar-redes.png"
            , iconRede "https://br.pinterest.com/chatadegalocha/" "-22px" "22px" "icons/sidebar-redes.png"
            , iconRede "https://www.youtube.com/user/blogchatadegalocha" "-44px" "29px" "icons/sidebar-redes.png"
            , iconRede "https://twitter.com/luferreira/" "-73px" "22px" "icons/sidebar-redes.png"
            , iconRede "https://chatadegalocha.tumblr.com/" "-95px" "11px" "icons/sidebar-redes.png"
            , iconRede "https://chatadegalocha.com/contato/" "-106px" "25px" "icons/sidebar-redes.png"
            , iconRede "https://feeds.feedburner.com/chatadegalocha/" "-131px" "17px" "icons/sidebar-redes.png"
            ]
        ]


header : Element msg
header =
    column [ width fill ]
        [ el
            [ width fill
            , paddingEach { top = 30, bottom = 45, left = 0, right = 0 }
            , B.widthEach { bottom = 8, top = 0, left = 0, right = 0 }
            , B.solid
            ]
            (link
                [ centerX ]
                { url = "#"
                , label =
                    image
                        [ width (fill |> maximum 290) ]
                        { description = "logo", src = "icons/logo.png" }
                }
            )
        , menu
        ]


body : Model -> Element msg
body model =
    column [ spacing 50 ]
        [ row [ width (fill |> minimum 1120), spacing 70 ]
            [ column [ width <| (fillPortion 8 |> maximum 800), height fill, alignTop, spacing 50 ] <|
                case model of
                    Loading ->
                        [ el [ centerX, centerY ] <| text "Abrindo..." ]

                    Failure ->
                        [ el [ centerX, centerY ] <| text "Deu merda..." ]

                    Success state ->
                        [ mainPost (Maybe.withDefault { id = 0, title = "", tags = [], date_published = "", image = "", image_desc = "" } (List.head state.posts)) ]
            , column [ width <| fillPortion 2, alignTop, spacing 50 ]
                [ image [] { src = "images/skincare.jpg", description = "SkinCare" }
                , image [] { src = "images/projeto-piloto.jpg", description = "Projeto Piloto" }
                ]
            ]
        , row
            [ spacing 50, width fill ]
          <|
            case model of
                Loading ->
                    [ el [ centerX, centerY ] <| text "Carregando..." ]

                Failure ->
                    [ el [ centerX, centerY ] <| text "Deu errado..." ]

                Success state ->
                    List.map miniPost state.posts
        ]


footer : Element Msg
footer =
    row [ paddingXY 20 35, EB.color (rgb255 0 0 0), width fill, moveDown 20 ]
        [ link [ width fill, alignTop ]
            { url = "#", label = image [ alignLeft, width (fill |> maximum 145) ] { src = "icons/footer-logo.png", description = "logo" } }
        , column
            [ width fill, spacing 30 ]
            [ row
                [ EF.color (rgb 1 1 1), spacing 20, alignRight ]
                [ link [ mouseOver [ EF.color active ] ] { url = "#", label = text "Sobre o CDG" }
                , link [ mouseOver [ EF.color active ] ] { url = "#", label = text "Anuncie" }
                , link [ mouseOver [ EF.color active ] ] { url = "#", label = text "Links" }
                , link [ mouseOver [ EF.color active ] ] { url = "#", label = text "Arquivo" }
                , link [ mouseOver [ EF.color active ] ] { url = "#", label = text "FAQ" }
                , link [ mouseOver [ EF.color active ] ] { url = "#", label = text "Shop" }
                ]
            , row
                [ width fill ]
                [ EI.text
                    [ EB.color (rgb 0 0 0)
                    , B.rounded 0
                    , EF.size 18
                    , EF.color (rgb 1 1 1)
                    , paddingEach { edges | left = 30, top = 5, bottom = 5 }
                    , width <| px 260
                    , inFront <|
                        image [ width <| px 26, centerY ]
                            { src = "icons/lupa.png"
                            , description = "search"
                            }
                    ]
                    { text = ""
                    , label = EI.labelHidden ""
                    , placeholder = Nothing
                    , onChange = \_ -> NoOp
                    }
                , row
                    [ alignRight ]
                    [ iconRede "https://www.instagram.com/chatadegalocha/" "0" "23px" "icons/rodape-social.png"
                    , iconRede "https://br.pinterest.com/chatadegalocha/" "-23px" "21px" "icons/rodape-social.png"
                    , iconRede "https://www.youtube.com/user/blogchatadegalocha" "-45px" "27px" "icons/rodape-social.png"
                    , iconRede "https://twitter.com/luferreira/" "-72px" "21px" "icons/rodape-social.png"
                    , iconRede "https://chatadegalocha.tumblr.com/" "-93px" "11px" "icons/rodape-social.png"
                    , iconRede "https://chatadegalocha.com/contato/" "-104px" "25px" "icons/rodape-social.png"
                    , iconRede "https://feeds.feedburner.com/chatadegalocha/" "-131px" "17px" "icons/rodape-social.png"
                    ]
                ]
            ]
        ]


license : Element msg
license =
    column
        [ EF.center
        , centerX
        , height fill
        , spacing 10
        , EF.size 14
        , EF.family [ EF.typeface "Open Sans", EF.sansSerif ]
        , EF.light
        ]
        [ paragraph [] [ text "Chata de Galocha by Luisa Ferreira is Licensed under a Creative Commons" ]
        , paragraph [] [ text "Attribution-Noncommercial-No Derivative Works 2.5 Brazil License" ]
        , paragraph [] [ text "Programação por PlicPlac" ]
        ]
