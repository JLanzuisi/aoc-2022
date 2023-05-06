package main

import (
	"bufio"
	"fmt"
	"golang.org/x/exp/slices"
	"log"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	filelist, dirlist := parse_input()
	fmt.Printf("Part 1: %v\n", part1(filelist, dirlist))
	fmt.Printf("Part 2: %v\n", part2(filelist, dirlist))
}

type file struct {
	name    string
	size    int
	parents string
}

func part2(f []file, d []string) int {
	const disksize = 70000000
	const targetsize = 30000000
	const root = "/root/"
	spaceneeded := 0
	spaceunused := 0
	rootsize := 0
	dirsize := 0
	var candidates []int

	for _, file := range f {
		if strings.Contains(file.parents, root) {
			rootsize += file.size
		}
	}

	spaceunused = disksize - rootsize
	spaceneeded = targetsize - spaceunused

	for _, dir := range d {
		dirsize = 0
		for _, file := range f {
			if strings.Contains(file.parents, dir) {
				dirsize += file.size
			}
		}
		if dirsize >= spaceneeded {
			candidates = append(candidates, dirsize)
		}
	}

	sort.Ints(candidates)

	return candidates[0]
}

func part1(f []file, d []string) int {
	const upperbound = 100000
	dirsize := 0
	result := 0

	for _, dir := range d {
		dirsize = 0
		for _, file := range f {
			if strings.Contains(file.parents, dir) {
				dirsize += file.size
			}
		}
		if dirsize < upperbound {
			result += dirsize
		}
	}

	//fmt.Println(dirlist)
	//fmt.Println(filelist)
	//fmt.Println(result)

	return result
}

func parse_input() ([]file, []string) {
	input, err := os.Open("input.txt")

	if err != nil {
		log.Fatal(err)
	}

	defer input.Close()

	inputscan := bufio.NewScanner(input)
	var line []string
	var parentlist []string
	var filelist []file
	var dirlist []string
	const root = "/root/"

	for inputscan.Scan() {
		line = strings.Split(inputscan.Text(), " ")
		fullpath := ""
		if line[0] == "$" { // its a command
			if line[len(line)-1] == ".." {
				parentlist = parentlist[:len(parentlist)-1]
			} else {
				if line[1] == "cd" {
					if line[2] == "/" {
						parentlist = append(parentlist, root)
					} else {
						parentlist = append(parentlist, line[2]+"/")
					}
					for _, s := range parentlist {
						fullpath += s
					}
					if !slices.Contains(dirlist, fullpath) {
						dirlist = append(dirlist, fullpath)
					}
				}
			}
		} else if line[0] != "dir" {
			size, _ := strconv.Atoi(line[0])
			for _, s := range parentlist {
				fullpath += s
			}
			filelist = append(filelist, file{line[1], size, fullpath})
		}
	}

	return filelist, dirlist
}
