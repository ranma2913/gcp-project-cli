package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
	"os"
	"os/exec"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "gcloud-project",
	Short: "View and Change GCP Projects",
	Long:  `gcloud-project CLI is a project which shows your GCP Projects and allows you to fuzzy search and change between them.`,
	// Uncomment the following line if your bare application
	// has an action associated with it:
	Run: func(cmd *cobra.Command, args []string) {
		// Execute the external command
		out, err := exec.Command("gcloud", "projects", "list").Output()
		if err != nil {
			fmt.Printf("Error executing gcloud command: %v\n", err)
			os.Exit(1)
		}

		// Print the output of the gcloud command
		fmt.Printf("Output:\n%s\n", out)
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	// Here you will define your flags and configuration settings.
	// Cobra supports persistent flags, which, if defined here,
	// will be global for your application.

	//rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.gcloud-project.yaml)")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
