{:user {:dependencies [[slamhound "1.5.5"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :plugins [[lein-kibit "0.0.8"]]
        :repl-options {:prompt (fn [ns] (str "λ " ns " ─➤ "))}}}
