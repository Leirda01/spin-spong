* [!] BUGFIX: ball can glitch through objects and out of the play-field's boundaries.

## Adriel

* [x] Implement 2nd paddle
* [x] Fix scoring system
* [x] Choose and use a proper naming convention for the nodes
* [x] Implement game restart after reaching a certain score
* [x] Implement scrolling background based on score
* [ ] Implement end game's visual elements
  * [x] (80%) the ball 'realistically' slows and stops out of reach other paddle
  * [x] Players must press Space to start a new game (it keeps it previous momentum)
  * [x] Score goes back to zero (and background goes back to center)
  * [x] A crown with the color of the winner pops up in the center of the play-field (thx luc)
* [ ] Implement gameplay mechanics
  * [x] (50%) When the ball's direction is nearly vertical, it becomes completely vertical 
  * [?] When no key is pressed, the paddle swings back to its default -vertical- position
  * [ ] Multiple speeds for the ball : fast when the paddle had momentum (smash) and slow/normal otherwise
* [ ] Rename 'session' from branches' names -> {luc, adriel}
* [x] Reorganize/clean up file structure ("shaders" and "materials")

## Luc

* [x] Research / experiment with particles
* [x] Implement first graphics into the game
* [x] Implement shader and material to modify sprites' color
* [x] (60%) Think about code / node structure for handling particles
* [x] Draw and animate victory crown
* [x] Implement victory crown
* [ ] Polish
  * [x] vibrations
  * [ ] freeze
  * [ ] Crosscode effect?
* [ ] Implement particle system
  * [ ] "Ball" - "Border" impact
  * [ ] "Ball" - "Paddle" impact
  * [x] goal impact
  * [x] victory impact
  * [ ] paddles' trails (once implemented but ultimately scrapped)
* [x] Translate this TO-DO list to English (I hate you Diana).
