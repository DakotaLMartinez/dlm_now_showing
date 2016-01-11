require "spec_helper"
require "pry"

describe "Movie Showings CLI" do 
  let!(:movie_data) { DlmNowShowing::MovieImporter.new("http://dakotaleemartinez.com/movie-data-for-test.json") }
  let!(:movie_controller) { DlmNowShowing::MovieShowingsController.new }
  it "allows a user to list movies now playing" do 
    expect(MovieShowingsController).to receive(:new).and_return(movie_controller)
    expect(movie_controller).to receive(:gets).and_return("movies", "exit")
    
    output = capture_puts {run_file("./bin/nowshowingtest")}
    
    expect(output).to include("1. Daddy's Home")
    expect(output).to include("2. Carol")
    expect(output).to include("3. Joy")
    expect(output).to include("4. Sisters")
    expect(output).to include("5. Alvin and the Chipmunks: The Road Chip")
    expect(output).to include("6. In the Heart of the Sea")
    expect(output).to include("7. Creed")
    expect(output).to include("8. Spotlight")
    expect(output).to include("9. Concussion")
    expect(output).to include("10. Point Break")
    expect(output).to include("11. The Night Before")
    expect(output).to include("12. Point Break 3D")
    expect(output).to include("13. Star Wars: The Force Awakens")
    expect(output).to include("14. The Big Short")
    expect(output).to include("15. The Hateful Eight")
    expect(output).to include("16. Star Wars: The Force Awakens 3D")
    expect(output).to include("17. Sherlock: The Abominable Bride")
    expect(output).to include("18. The Danish Girl")
    expect(output).to include("19. The Good Dinosaur")
    expect(output).to include("20. The Hunger Games: Mockingjay, Part 2")
    expect(output).to include("21. Bajirao Mastani")
    expect(output).to include("22. Anomalisa")
    expect(output).to include("23. The Revenant")
    expect(output).to include("24. Eternal Sunshine of the Spotless Mind")
    expect(output).to include("25. Son of Saul")
    expect(output).to include("26. 45 Years")
    expect(output).to include("27. Mustang")
    expect(output).to include("28. Theeb")
    expect(output).to include("29. Young Cassidy")
    expect(output).to include("30. The Room")
    expect(output).to include("31. Brooklyn")
    expect(output).to include("32. Trumbo")
    expect(output).to include("33. Bridge of Spies")
    expect(output).to include("34. Spectre")
    expect(output).to include("35. The Martian")
    expect(output).to include("36. Star Wars: The Force Awakens -- An IMAX 3D Experience")
    
  end
end