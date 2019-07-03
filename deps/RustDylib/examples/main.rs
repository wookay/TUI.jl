// cargo run --example main

// code from https://github.com/fdehau/tui-rs/blob/master/tests/paragraph.rs

extern crate tui;
use tui::backend::TestBackend;
#[allow(unused_imports)] use tui::buffer::Buffer;
use tui::layout::Alignment;
use tui::widgets::{Block, Borders, Paragraph, Text, Widget};
use tui::Terminal;

#[allow(dead_code)]
fn println<T>(x: T) where T: std::fmt::Debug {
    println!("{:?}", x);
}

fn print<T>(x: T) where T: std::fmt::Debug {
    print!("{:?}", x);
}

fn main() {
    const SAMPLE_STRING: &str =
    "The library is based on the principle of immediate rendering with \
     intermediate buffers. This means that at each new frame you should build all widgets that are \
     supposed to be part of the UI. While providing a great flexibility for rich and \
     interactive UI, this may introduce overhead for highly dynamic content.";

    let render = |alignment| {
        let backend = TestBackend::new(20, 10);
        let mut terminal = Terminal::new(backend).unwrap();

        terminal
            .draw(|mut f| {
                let size = f.size();
                let text = [Text::raw(SAMPLE_STRING)];
                Paragraph::new(text.iter())
                    .block(Block::default().borders(Borders::ALL))
                    .alignment(alignment)
                    .wrap(true)
                    .render(&mut f, size);
            })
            .unwrap();
        terminal.backend().buffer().clone()
    };

    print(render(Alignment::Left));
}
