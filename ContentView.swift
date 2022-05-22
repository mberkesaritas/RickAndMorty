//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Berke Sarıtaş on 22.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    
    let urlString = "https://rickandmortyapi.com/api/character"
    @State var characterList : [String] = []
    
    func getData(from url : String) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
            data , response , error in
            
            guard let data = data , error == nil else{
                print("something went worng")
                return
            }
            
            var result : Response?
            do {
                result =  try JSONDecoder().decode(Response.self, from: data)
            } catch  {
                print(error.localizedDescription)
            }
            
            guard let json = result else {
                return
            }
            
            
            for fill in json.results {
                characterList.append(fill.name)
                print(characterList)
            }
            
            
       
           

            
        }).resume()
    }
    
    struct Response : Codable  {
        let results : [source]
        }
    
    struct source : Codable {
        
        let id : Int
        let name : String
        let status : String
        
    }
    
   
    var body: some View {
        
        VStack{
            List{
                
                ForEach(characterList ,id: \.self){ character in
                    
                    Button(character){
                        print("basıldı")
                    }
                    .foregroundColor(Color.black)
                    
                }
                
            }.navigationTitle("Rick And Morty")
            
            
            
            Button("View"){
             getData(from: urlString)
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
