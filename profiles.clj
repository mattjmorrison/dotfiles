{:user {:dependencies [[slamhound "1.5.5"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :plugins [[lein-kibit "0.0.8"]
                  [com.jakemccrary/lein-test-refresh "0.5.5"]
                  [venantius/ultra "0.1.9"]]
        :repl-options {:prompt (fn [ns] (str "λ " ns " ─➤ "))}
        :ultra {:color-scheme :solarized_dark}}}
