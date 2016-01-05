alias be 'bundle exec';

function bers -d "Runs: bundle exec rails s"
  bundle exec rails s
end

function berc -d "Runs: bundle exec rails s"
  bundle exec rails c
end
