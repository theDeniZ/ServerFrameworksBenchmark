package main

import (
	"io/ioutil"
	"math/rand"
	"strconv"

	"github.com/gin-gonic/gin"
)

func rnd() int {
	return rand.Intn(1000)
}

func rndString() string {
	return strconv.Itoa(rnd())
}

func main() {
	gin.DefaultWriter = ioutil.Discard

	r := gin.Default()
	r.GET("/simple", func(c *gin.Context) {
		c.String(200, rndString())
	})

	r.GET("/json", func(c *gin.Context) {
		data := gin.H{
			"Number 1":  rndString(),
			"Number 2":  rndString(),
			"Number 3":  rndString(),
			"Number 4":  rndString(),
			"Number 5":  rndString(),
			"Number 6":  rndString(),
			"Number 7":  rndString(),
			"Number 8":  rndString(),
			"Number 9":  rndString(),
			"Number 10": rndString(),
			"Number 11": rndString(),
			"Number 12": rndString(),
			"Number 13": rndString(),
			"Number 14": rndString(),
			"Number 15": rndString(),
			"Number 16": rndString(),
			"Number 17": rndString(),
			"Number 18": rndString(),
			"Number 19": rndString(),
			"Number 20": rndString(),
		}
		c.JSON(200, data)
	})

	r.StaticFile("/static.html", "./resources/static.html")

	r.Run(":8088") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
