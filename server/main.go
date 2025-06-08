package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

type Stream struct {
	ID          uint   `gorm:"primaryKey" json:"id"`
	Title       string `json:"title"`
	Description string `json:"description"`
}

func setupDatabase() *gorm.DB {
	db, err := gorm.Open(sqlite.Open("streams.db"), &gorm.Config{})
	if err != nil {
		log.Fatalf("failed to connect database: %v", err)
	}
	if err := db.AutoMigrate(&Stream{}); err != nil {
		log.Fatalf("failed to migrate database: %v", err)
	}
	return db
}

func main() {
	db := setupDatabase()

	r := gin.Default()

	r.GET("/streams", func(c *gin.Context) {
		var streams []Stream
		if err := db.Find(&streams).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, streams)
	})

	r.POST("/streams", func(c *gin.Context) {
		var s Stream
		if err := c.ShouldBindJSON(&s); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := db.Create(&s).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusCreated, s)
	})

	if err := r.Run(":8080"); err != nil {
		log.Fatalf("server error: %v", err)
	}
}
