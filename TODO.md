## BUGFIX

* [ ] Rework physics with builtin functions or in other more viable ways
  * [ ] (50%) Ball can glitch through objects and out of the play-field's boundaries
  * [x] Ball can get stuck out of range vertically
  * [ ] Manage ball speed
  * [?] Change RigidBody2D to Kinematic to gain a finer control over physics
* [x] Modify viewport to get proper clear color

## Adriel

* [x] Implement 2nd paddle
* [x] Fix scoring system
* [x] Choose and use a proper naming convention for the nodes
* [x] Implement game restart after reaching a certain score
* [x] Implement scrolling background based on score
* [x] Implement end game's visual elements
  * [ ] (80%) the ball 'realistically' slows and stops out of reach other paddle
  * [x] Players must press Space to start a new game (it keeps it previous momentum)
  * [x] Score goes back to zero (and background goes back to center)
  * [x] A crown with the color of the winner pops up in the center of the play-field (thx luc)
* [ ] Implement gameplay mechanics
  * [x] When the ball's direction is nearly vertical, it becomes completely vertical 
  * [?] When no key is pressed, the paddle swings back to its default -vertical- position
  * [ ] Multiple speeds for the ball: fast when the paddle had momentum (smash) and slow/normal otherwise
* [x] Rename 'session' from branches' names -> {luc, adriel}
* [x] Reorganize/clean up file structure ("shaders" and "materials")

## Luc

* [x] Research / experiment with particles
* [x] Implement first graphics into the game
* [x] Implement shader and material to modify sprites' color
* [x] Think about code / node structure for handling particles
* [x] Draw and animate victory crown
* [x] Implement victory crown
* [x] Polish
  * [x] vibrations
  * [x] freeze
* [ ] Implement particle system
  * [ ] (70%) "Ball" - "Border" impact
  * [ ] (10%) "Ball" - "Paddle" impact
  * [x] goal impact
  * [x] victory impact
* [x] Translate this TO-DO list to English (I hate you Diana)
* [x] Revamp score ui
