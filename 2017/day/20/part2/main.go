package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
    "strconv"
)

type Coordinate struct {
    x int
    y int
    z int
}

type Particle struct {
    p Coordinate
    v Coordinate
    a Coordinate
    index int
}

func abs(a int) int {
    if a < 0 {
        return a * -1
    }

    return a
}

func max(a int, b int) int {
    if a > b {
        return a
    }

    return b
}

func (c Coordinate) distance() int {
    return max(max(abs(c.x), abs(c.y)), abs(c.z))
}

func (p Particle) distance() int {
    return p.p.distance()
}

func (p *Particle) move() bool {

    oldDistance := p.distance()

    p.v.x += p.a.x
    p.v.y += p.a.y
    p.v.z += p.a.z

    p.p.x += p.v.x
    p.p.y += p.v.y
    p.p.z += p.v.z

    newDistance := p.distance()

    return oldDistance < newDistance
}

func (c Particle) equals(o Particle) bool {
    return  c.p.x == o.p.x && c.p.y == o.p.y && c.p.z == o.p.z
}

func removeDuplicates(particles []Particle) []Particle {
    duplicates := map[Coordinate]bool {}
    result := []Particle {}

    for i := range particles {
        if !duplicates[particles[i].p] {
            for j:=i+1; j < len(particles); j++ {
                if (particles[j].equals(particles[i])) {
                    duplicates[particles[i].p] = true
                    break
                }
            }
            if !duplicates[particles[i].p] {
                result = append(result, particles[i])
            }
        }
    }
    return result
}

func ParticleSwarm(particles []Particle) int {
    awayFromZero := 0
    for awayFromZero < 2 {

        awayFromZero++
        for i,_ := range particles {
            if !particles[i].move() {
                awayFromZero = 0
            }
        }

        particles = removeDuplicates(particles)
    }

    return len(particles)
}

func readCoordinate(input string) Coordinate {
    input = strings.TrimSpace(input[:len(input)-1])
    values := strings.Split(input, ",")
    x, _ := strconv.Atoi(values[0])
    y, _ := strconv.Atoi(values[1])
    z, _ := strconv.Atoi(values[2])
    return Coordinate {
        x : x,
        y : y,
        z : z,
    }
}

func ReadInput(fileName string) []Particle {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []Particle {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), ", ")
        particle := Particle {
            p : readCoordinate(line[0][3:]),
            v : readCoordinate(line[1][3:]),
            a : readCoordinate(line[2][3:]),
            index : len(result),
        }
        result = append(result, particle)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := ParticleSwarm(input)
    fmt.Println(result)
}