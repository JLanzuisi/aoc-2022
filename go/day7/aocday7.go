package aocday7

import (
	"bufio"
	"fmt"
	"golang.org/x/exp/slices"
	"log"
	"os"
	"strconv"
	"strings"
)

type file struct {
	name    string
	size    int
	parents []string
}

func aocday7() {
	filelist, dirlist := parse_input()

	fmt.Println(filelist)
	fmt.Println(dirlist)
}

func parse_input() ([]file, []string) {
	input, err := os.Open("example.txt")

	if err != nil {
		log.Fatal(err)
	}

	defer input.Close()

	inputscan := bufio.NewScanner(input)
	var line []string
	var parentlist []string
	var filelist []file
	var dirlist []string

	for inputscan.Scan() {
		line = strings.Split(inputscan.Text(), " ")
		if line[0] == "$" { // its a command
			if line[len(line)-1] == ".." {
				parentlist = parentlist[:len(parentlist)-1]
			} else {
				if line[1] == "cd" {
					parentlist = append(parentlist, line[2])

				}
			}
		} else if line[0] != "dir" {
			size, _ := strconv.Atoi(line[0])
			filelist = append(filelist, file{
				name:    line[1],
				size:    size,
				parents: parentlist,
			})
		}
	}

	return filelist, dirlist
}
