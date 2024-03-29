package main

import (
	"fmt"
	"net/http"
)

func main() {
	// Start the server
	StartServer()

}

// Path: server.go
func StartServer() {
	// Start the server
	fmt.Println("Server started at :8080")
	http.HandleFunc("/hello", HelloWord)
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Println("Error starting server")
		return
	}
}

func HelloWord(
	w http.ResponseWriter,
	r *http.Request) {
	_, err := w.Write([]byte("Hello World"))
	if err != nil {
		fmt.Println("Error writing response")
		return
	}

}
