#!/bin/bash

# Скрипт для установки всех необходимых пакетов LaTeX для Manim
# Использование: ./setup_latex.sh

set -e  # Остановка при ошибке

echo "🔍 Поиск пути к tlmgr..."

# Функция для поиска tlmgr
find_tlmgr() {
    # 1. Проверяем, доступен ли tlmgr в PATH
    if command -v tlmgr &> /dev/null; then
        TLMGR_PATH=$(command -v tlmgr)
        echo "$(dirname "$TLMGR_PATH")"
        return 0
    fi
    
    # 2. Проверяем стандартный путь для BasicTeX на macOS
    if [ -f "/Library/TeX/texbin/tlmgr" ]; then
        echo "/Library/TeX/texbin"
        return 0
    fi
    
    # 3. Ищем в /usr/local/texlive (полная установка TeX Live)
    TEXLIVE_PATH=$(find /usr/local/texlive -name tlmgr -type f 2>/dev/null | head -1)
    if [ -n "$TEXLIVE_PATH" ]; then
        echo "$(dirname "$TEXLIVE_PATH")"
        return 0
    fi
    
    # 4. Ищем в других возможных местах
    for path in "/opt/local/bin" "/usr/texbin" "$HOME/Library/TeX/texbin"; do
        if [ -f "$path/tlmgr" ]; then
            echo "$path"
            return 0
        fi
    done
    
    return 1
}

# Находим путь к tlmgr
TEXLIVE_PATH=$(find_tlmgr)

if [ -z "$TEXLIVE_PATH" ]; then
    echo "❌ Ошибка: tlmgr не найден!"
    echo ""
    echo "Попробуйте выполнить следующие шаги:"
    echo "1. Установите BasicTeX: brew install --cask basictex"
    echo "2. После установки добавьте путь в PATH:"
    echo "   export PATH=\"/Library/TeX/texbin:\$PATH\""
    echo "3. Или добавьте в ~/.zshrc:"
    echo "   echo 'export PATH=\"/Library/TeX/texbin:\$PATH\"' >> ~/.zshrc"
    echo "   source ~/.zshrc"
    exit 1
fi

echo "✅ Найден путь: $TEXLIVE_PATH"
echo ""

echo "📦 Обновление менеджера пакетов..."
sudo $TEXLIVE_PATH/tlmgr update --self

echo ""
echo "📦 Установка необходимых пакетов LaTeX для Manim..."
sudo $TEXLIVE_PATH/tlmgr install \
  standalone \
  preview \
  dvisvgm \
  amsmath \
  amssymb \
  babel-english \
  babel \
  latex-bin \
  xcolor \
  geometry \
  ulem \
  amscls \
  amsfonts

echo ""
echo "🔄 Обновление базы данных пакетов LaTeX..."
sudo $TEXLIVE_PATH/mktexlsr

echo ""
echo "✅ Проверка установки..."
echo ""

# Проверка LaTeX
if command -v latex &> /dev/null; then
    echo "✅ LaTeX найден: $(which latex)"
else
    echo "⚠️  LaTeX не найден в PATH. Выполните: eval \"\$(/usr/libexec/path_helper)\""
fi

# Проверка dvisvgm
if command -v dvisvgm &> /dev/null; then
    echo "✅ dvisvgm найден: $(which dvisvgm)"
else
    echo "⚠️  dvisvgm не найден в PATH"
fi

# Проверка установленных пакетов
echo ""
echo "📋 Проверка установленных пакетов:"
$TEXLIVE_PATH/tlmgr list --only-installed | grep -E "(standalone|preview|dvisvgm)" || echo "⚠️  Некоторые пакеты не найдены"

echo ""
echo "🎉 Установка завершена!"
echo ""
echo "📝 Следующие шаги:"
echo "1. Перезапустите ядро Jupyter (Kernel → Restart Kernel)"
echo "2. Запустите ячейку инициализации в manim_playground.ipynb"
echo "3. Проверьте, что LaTeX найден в выводе"

