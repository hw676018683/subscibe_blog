every 1.day, at: '1:30 am' do
  rake 'blog:get_articles', output: { error: ENV['WHENEVER_ERROR_LOG'], standard: ENV['WHENEVER_CRONS_LOG'] }
end