// @ts-check


//-- MAIN

const main = init()

function init () {
    return Model(0)
}


//-- MODEL

/** @typedef {number} Model */

/** @param {number} i */
function Model (i) {
    return {
        get model () {
            return i
        },
        set model (n) {
            i = n
        }
    }
}


//-- UPDATE

/**
 * @param {Model} model
 * @param {number} n
 * @returns {Model}
 */
function increaser (model, n) {
    model += n
    return model
}
/**
 * @param {Model} model
 * @param {number} n
 * @returns {Model}
 */
function decreaser (model, n) {
    model -= n
    return model
}

/**
 * @param {string} msg
 * @param {Model} model
 * @returns {Model}
 */
function update (msg, model) {
    switch (msg) {
        case 'Increment': return increaser(model, 1)
        case 'Decrement': return model -1
        case 'Reset': return 0
        case 'Increment10': return increaser(model, 10)
        case 'Decrement10': return decreaser(model, 10)
    }
}


//-- VIEW


/** view : Model -> Html Msg
 * @param {Model} model
 * @returns {string}
 */
function view (model) {
    view model =
    div []
        [
        div [] [ text (String.fromInt model) ]
        , button [ onClick Decrement10 ] [ text "minus 10" ]
        , button [ onClick Decrement ] [ text "minus" ]
        , button [ onClick Increment ] [ text "plus" ]
        , button [ onClick Increment10 ] [ text "plus 10" ]
        , div []
        [
                button [ onClick Reset ] [ text "reset" ]
            ]
        ]
}
