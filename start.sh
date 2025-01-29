# Check if the UPSTREAM_REPO variable is set
if [ -z "$UPSTREAM_REPO" ]; then
  echo "Cloning main Repository..."
  git clone https://github.com/Deendayal403/Deendayal_dhakad.git /Deendayal_dhakad
else
  echo "Cloning Custom Repository from $UPSTREAM_REPO..."
  git clone "$UPSTREAM_REPO" /Deendayal_dhakad
fi

echo "Setting up virtual environment..."
python3 -m venv /Deendayal_dhakad/venv

source /Deendayal_dhakad/venv/bin/activate

cd /Deendayal_dhakad
pip install --no-cache-dir -U -r requirements.txt

# Start the bot
echo "Starting Deendayal_botz..."
exec python3 bot.py
