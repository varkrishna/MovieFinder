# MovieFinder

A Mac-OS command line utility for finding **best IMDB rated** movie in a folder. Just specify folder path of movies


# Steps to build

 **open your terminal**
 - git clone https://github.com/varkrishna/MovieFinder.git
 - cd MovieFinder
 - swift build 
 - .build/debug/MovieFinder -t **Folder path of movies**
 **Example**
 > .build/debug/MovieFinder -t /Users/Alice/Desktop/Movies

## Alternative Way 

After **swift build** command you can copy executable **MovieFinder** from **.build/debug** directory and copy to another place like **desktop** and run that executable from there.

    ./MovieFinder -t /Users/Alice/Desktop/Movies



 
## Options
Write now it supports only one option **-t** and it accepts folder path of movies 

## Output

It creates a text file named **result.txt** in same folder of movies. And that file containes all movies name and rating.
**All movies that are failed to recognize will have rating 0.0**

## Example of output
Toy Story 3  = 8.3 
Inside Out  = 8.2 
Secret Superstar  = 8.1 
Shaadi Mein Zaroor Aana  = 7.9 
Big Hero 6  = 7.8 
Ready player one = 7.7 
Hichki  = 7.6 
War for the Planet of the Apes  = 7.5 
Lone Survivor  = 7.5 
The Accountant  = 7.4 
Zero Dark Thirty  = 7.4 
The Equalizer  = 7.2 
War Dogs  = 7.1 
Passengers  = 7.0 
Jack Reacher  = 7.0 
Mr. Peabody & Sherman  = 6.8 
Appleseed Alpha  = 6.6 
Resident Evil Damnation  = 6.6 
12 Strong  = 6.6 
Resident Evil Degeneration  = 6.5 
Hyena Road  = 6.5 
Tomb Raider  = 6.4 
The BFG  = 6.4 
Resident Evil Vendetta  = 6.3 
Jack Reacher Never Go Back  = 6.1 
Resident Evil The Final Chapter  = 5.6 


 

