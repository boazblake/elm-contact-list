module Update exposing (..)

import Commands exposing (savePlayerCmd)
import Routing exposing (parseLocation)
import Msgs exposing (Msg(..))
import Models.State exposing (Model)
import Models.Player exposing (Player)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
          ( { model | players = response}, Cmd.none )

        Msgs.OnLocationChange location ->
          let
              newRoute =
                parseLocation location
          in
              ( {model | route = newRoute }, Cmd.none )
        
        Msgs.ChangeLevel player howMuch ->
          let
              updatedPlayer =
                { player | level = player.level + howMuch }
          in
              (model, savePlayerCmd updatedPlayer )
        
        Msgs.OnPlayerSave (Ok player) ->
          ( updatePlayer model player, Cmd.none)
        
        Msgs.OnPlayerSave (Err error) ->
          (model, Cmd.none)

updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
  let
      pick currentPlayer =
        if updatedPlayer.id == currentPlayer.id
          then
            updatedPlayer
        else
          currentPlayer
      
      updatePlayerList players =
        List.map pick players

      updatePlayers =
        RemoteData.map updatePlayerList model.players
  in
      { model | players = updatePlayers }