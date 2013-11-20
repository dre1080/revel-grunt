package grunt

import (
	"github.com/robfig/revel"
	"io"
	"os"
	"os/exec"
)

func AppInit() {
	if revel.DevMode {
		if err := os.Chdir(revel.BasePath); err != nil {
			revel.ERROR.Panic(err)
		}

		cmd := exec.Command("grunt")
		stdout, err := cmd.StdoutPipe()
		if err != nil {
			revel.ERROR.Panic(err)
		}

		stderr, err := cmd.StderrPipe()
		if err != nil {
			revel.ERROR.Panic(err)
		}

		if err := cmd.Start(); err != nil {
			revel.ERROR.Panic(err)
		}

		go io.Copy(os.Stdout, stdout)
		go io.Copy(os.Stderr, stderr)
		go cmd.Wait()
	}
}
