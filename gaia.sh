#!/bin/bash

echo -e '\033[0;31m'
echo -e ' ███████╗██╗██████╗ ███████╗'
echo -e ' ██╔════╝██║██╔══██╗██╔════╝'
echo -e ' █████╗  ██║██████╔╝█████╗  '
echo -e ' ██╔══╝  ██║██╔══██╗██╔══╝  '
echo -e ' ██║     ██║██║  ██║███████╗'
echo -e ' ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝'
echo -e '\033[0m'
echo -e "🔥 Подпишись на @cryptofire8 в Telegram [🚀]"

# Функция установки ноды
download_node() {
    echo "🔄 Остановка процессов на 8080 порту..."
    sudo fuser -k 8080/tcp
    
    echo "📦 Обновление системы и установка необходимых пакетов..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y python3-pip python3-dev python3-venv curl git build-essential tmux
    
    echo "📌 Установка Python-зависимостей..."
    pip3 install aiohttp
    
    echo "🚀 Установка GaiaNet..."
    curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash
    source ~/.bashrc
    
    echo "🛠️ Инициализация ноды с выбранной моделью..."
    gaianet init --config https://raw.gaianet.ai/qwen-1.5-0.5b-chat/config.json
    
    echo "🚀 Запуск ноды..."
    gaianet start
}

# Функция просмотра информации о ноде
check_states() {
    echo "📊 Проверка состояния ноды..."
    gaianet info
}

# Функция вывода логов
check_logs() {
    echo "📜 Вывод логов ноды..."
    journalctl -u gaianet --no-pager --lines=100
}

# Функция удаления ноды
delete_node() {
    echo "🗑️ Удаление ноды..."
    gaianet stop
    curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/uninstall.sh' | bash
    sudo rm -rf $HOME/gaianet
    echo "✅ Нода полностью удалена!"
}

# Функция выхода
exit_from_script() {
    echo "👋 Выход из скрипта."
    exit 0
}

# Главное меню
while true; do
    echo -e "\n\n🔥 Меню управления GaiaNet:"
    echo "1. ✨ Установить ноду"
    echo "2. 📊 Посмотреть данные"
    echo "3. 🟦 Посмотреть логи"
    echo "4. 🗑️ Удалить ноду"
    echo "5. 👋 Выйти из скрипта"
    read -p "Выберите пункт меню: " choice

    case $choice in
      1) download_node ;;
      2) check_states ;;
      3) check_logs ;;
      4) delete_node ;;
      5) exit_from_script ;;
      *) echo "❌ Неверный пункт. Попробуйте снова." ;;
    esac
  done
