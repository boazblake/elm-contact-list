module Slides.Show exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models.Slide exposing (Slide)
import Routing exposing (slidesPath)

view: Slide -> Html Msg
view model =
  div []
    [ nav model
    , slideShow model
    ]

nav : Slide -> Html Msg
nav model =
  div [ class "clearfix mb2 white bg-black p1" ]
      [ listBtn ]

listBtn : Html Msg
listBtn =
  a
    [ class "btn regular"
    , href slidesPath
    ]
    [ i [ class "fa fa-chevron-left mr1"] [], text "List"]

slideShow : Slide -> Html Msg
slideShow slide =
    div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-5 h2 bold"] [ text "SLIDE SHOW" ]
    , div [ class "col col-7" ]
        [ span [ class "h1 bold" ] [ p [] [ text (toString slide.content) ]]
        ]
    ]