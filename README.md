# gallery

Проект для создания математических анимаций с помощью Manim в Jupyter Notebook.

## 🚀 Быстрый старт

1. **Установите зависимости:**
   ```bash
   uv sync
   ```

2. **Установите LaTeX (для работы с MathTex):**
   ```bash
   brew install --cask basictex
   eval "$(/usr/libexec/path_helper)"
   ./setup_latex.sh
   ```

3. **Запустите Jupyter Lab:**
   ```bash
   uv run jupyter lab
   ```

4. **Откройте `manim_playground.ipynb` и начните создавать анимации!**

## 📖 Подробная документация

См. [MANIM_GUIDE.md](MANIM_GUIDE.md) для полных инструкций по настройке и использованию.

## 📝 Исходная настройка проекта

```shell
source .venv/bin/activate 
manim init project gallery  --default
```

# 📚 Полезные советы

### Настройка качества:
```python
render_scene(MyAnimation, quality="low_quality")    # Быстро, для тестов
render_scene(MyAnimation, quality="medium_quality") # Средне
render_scene(MyAnimation, quality="high_quality")   # Медленно, для финала
```

### Основные анимации:
- `Create()` - рисование объекта
- `Write()` - написание текста
- `FadeIn() / FadeOut()` - появление/исчезание
- `Transform()` - трансформация одного объекта в другой
- `ReplacementTransform()` - замена одного объекта другим
- `Rotate()` - вращение
- `.animate` - синтаксис для плавных изменений

### Основные цвета:
`RED`, `GREEN`, `BLUE`, `YELLOW`, `PINK`, `ORANGE`, `PURPLE`, `WHITE`, `BLACK`, `GRAY`

### Позиционирование:
- `.shift(UP)`, `.shift(DOWN)`, `.shift(LEFT)`, `.shift(RIGHT)`
- `.to_edge(UP)`, `.to_edge(DOWN)`, etc.
- `.next_to(other_object, direction)`
- `.move_to(position)`

### Группировка:
```python
group = VGroup(obj1, obj2, obj3)
self.play(FadeIn(group))  # Анимирует всю группу
```

### Документация:
- Официальная документация: https://docs.manim.community/
- Примеры: https://docs.manim.community/en/stable/examples.html



