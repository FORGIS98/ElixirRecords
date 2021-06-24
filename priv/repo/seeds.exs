# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Elixirrecords.Repo.insert!(%Elixirrecords.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Elixirrecords.Repo
alias Elixirrecords.{User, Event}

%User{nickname: "aragon", email: "aragon@email.com", password: "aragon"} |> Repo.insert!()
%User{nickname: "biblo", email: "biblo@email.com", password: "biblo"} |> Repo.insert!()
%User{nickname: "gandalf", email: "gandalf@email.com", password: "gandalf"} |> Repo.insert!()
%User{nickname: "hackerman", email: "hackerman@email.com", password: "theH4ackerm4n"} |> Repo.insert!()

%Event{name: "Wonder Woman", description: "Diana must contend with a work colleague and businessman, whose desire for extreme wealth sends the world down a path of destruction, after an ancient artifact that grants wishes goes missing."} |> Repo.insert!()
%Event{name: "Soul", description: "After landing the gig of a lifetime, a New York jazz pianist suddenly finds himself trapped in a strange land between Earth and the afterlife."} |> Repo.insert!()
%Event{name: "Noticias del Gran Mundo", description: "A Civil War veteran agrees to deliver a girl, taken by the Kiowa people years ago, to her aunt and uncle, against her will. They travel hundreds of miles and face grave dangers as they search for a place that either can call home."} |> Repo.insert!()
%Event{name: "Pequeños Detalles", description: "Kern County Deputy Sheriff Joe Deacon is sent to Los Angeles for what should have been a quick evidence-gathering assignment. Instead, he becomes embroiled in the search for a serial killer who is terrorizing the city."} |> Repo.insert!()
%Event{name: "Nomadland", description: "A woman in her sixties, after losing everything in the Great Recession, embarks on a journey through the American West, living as a van-dwelling modern-day nomad."} |> Repo.insert!()
%Event{name: "Tom y Jerry", description: "A chaotic battle ensues between Jerry Mouse, who has taken refuge in the Royal Gate Hotel, and Tom Cat, who is hired to drive him away before the day of a big wedding arrives."} |> Repo.insert!()
%Event{name: "Nadie", description: "A bystander who intervenes to help a woman being harassed by a group of men becomes the target of a vengeful drug lord."} |> Repo.insert!()
%Event{name: "Chaos Walking", description: "Two unlikely companions embark on a perilous adventure through the badlands of an unexplored planet as they try to escape a dangerous and disorienting reality, where all inner thoughts are seen and heard by everyone."} |> Repo.insert!()
%Event{name: "The Kinkg's Man", description: "In the early years of the 20th century, the Kingsman agency is formed to stand against a cabal plotting a war to wipe out millions."} |> Repo.insert!()
%Event{name: "Morbius", description: "Biochemist Michael Morbius tries to cure himself of a rare blood disease, but he inadvertently infects himself with a form of vampirism instead."} |> Repo.insert!()
