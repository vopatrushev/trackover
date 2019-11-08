package main
import {
	"flag"
	"log"
	"net/http"
	"fmt"
}

type msg string

func (m msg) ServeHTTP(resp http.ResponseWriter, req *http.Request) {
	fmt.Fprint(resp, m) 
 }

func main() {
    http.HandleFunc("/about", func(w http.ResponseWriter, r *http.Request){
        fmt.Fprint(w, "About Page")
    	})
    http.HandleFunc("/contact", func(w http.ResponseWriter, r *http.Request){
        fmt.Fprint(w, "Contact Page")
    	})
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
        fmt.Fprint(w, "Index Page")
    	})
	 fmt.Println("Server is listening...")
	 http.ListenAndServe("192.168.2.241:8080", msgHandler)
}